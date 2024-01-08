Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7379D8
	for <linux-ide@vger.kernel.org>; Mon,  8 Jan 2024 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McLKGz4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0E8C433C8;
	Mon,  8 Jan 2024 06:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704695153;
	bh=Hw6xtmvMh0xhl45JsfYXFfX+rF4O31Dk77LoOn3adX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=McLKGz4ruviGKF5NCh/CSvbH+AO9XcNXlef3wlwYmlaapM6eQe85CuuzgSOnlw6hT
	 gtRI+O+zaaKTlsJdPaWT88W+UrdmEHBRvFCwWmptOFa3NQl5XcOmUaVZyN3Sr7nZ0T
	 Rn1d5GCQ4jJZcpcv6K3Ip5MSV+j8dGnp1lLHiGPZfdsHW1igL+xftu7An2IHjd2H0M
	 qv9f/6selV3gD/Y/e6tinbI8MuVAoSoYK86sroRhJXnjQxAytqa+1wYzPuvFHotWp0
	 5uFIvrjZ53jRdMnwsBYHhtrHbyvCgJ03tAJi2+TdWab3HW37t+y0Qx9lPFJHcp1Ndi
	 p5wgz6oYTYikg==
Message-ID: <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
Date: Mon, 8 Jan 2024 15:25:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240107180258.360886-2-phill@thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 03:02, Phillip Susi wrote:
> When a disk is in SLEEP mode it can not respond to any
> any commands.  Several commands are simply a NOOP to a disk
> that is in standby mode, but when a disk is in SLEEP mode,
> they frequencly cause the disk to spin up for no reason.
> To avoid this, complete these commands in libata without
> waking the disk.  These commands are:

As commented in patch 3/3, please use full 72-char lines for commit messages.

> 
> CHECK POWER MODE
> FLUSH CACHE
> SLEEP
> STANDBY IMMEDIATE
> IDENTIFY
> 
> If we know the disk is sleeping, we don't need to wake it up
> to find out if it is in standby, so just pretend it is in

sleep and standby are different power states. So saying that a disk that is
sleeping is in standby does not make sense. And if you wake up a drive from
sleep mode, it will *not* be in standby (need to re-check, but I think that
holds true even with PUIS enabled).

> standby.  While asleep, there's no dirty pages in the cache,
> so there's no need to flush it.  There's no point in waking
> a disk from sleep just to put it back to sleep.  We also have
> a cache of the IDENTIFY information so just return that
> instead of waking the disk.

The problem here is that ATA_DFLAG_SLEEPING is a horrible hack to not endup with
lots of timeout failures if the user execute "hdparm -Y". Executing such
passthrough command with a disk being used by an FS (for instance) is complete
nonsense and should not be done.

So I would rather see this handled correctly, through the kernel pm runtime
suspend/resume:
1) Define a libata device sysfs attribute that allows going to sleep instead of
the default standby when the disk is runtime suspended. If sleep is used, set
ATA_DFLAG_SLEEPING.
2) With that, any command issued to the disk will trigger runtime resume. If
ATA_DFLAG_SLEEPING is set, then the drive can be woken up with a link reset from
EH, going through ata_port_runtime_resume(), exactly like with the default
standby state for suspend. ATA_DFLAG_SLEEPING being set or not will indicate if
a simple verify command can spinup the disk or if a link abort is needed (like
done now in ata_qc_issue() which is really a nasty place to do that).

Now, the annoying thing is the drive being randomly woken-up due to commands
being issued, like the ones you mention. This is indeed bad, and seeing news
like this:

https://www.phoronix.com/news/Linux-PM-Regulatory-Bugs

I think we really should do better...

But I do not think the kernel is necessarilly the right place to fix this, at
least in the case of commands issued from userspace by things like smartd or
udevd. Patching there is needed to avoid uselessly waking up disks in runtime
suspend. systemd already has power policies etc, so there is integration with
the kernel side power management. Your issues come from using a tool (hdparm)
that has no integration at all with the OS daemons.

For FSes issued commands like flush, these are generally not random at all. If
you see them appearing randomly, then there is a problem with the FS and
patching the FS may be needed. Beside flush, there are other things to consider
here. Ex: FSes using zoned block devices (SMR disks) doing garbage collection
while idle. We cannot prevent this from happening, which is why I seriously
dislike the idea of faking any command for a sleeping disk.


> ---
>  drivers/ata/libata-core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 09ed67772fae..6c5269de4bf2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5040,6 +5040,26 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
>  
>  	/* if device is sleeping, schedule reset and abort the link */
>  	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
> +		switch (qc->tf.command)
> +		{
> +		case ATA_CMD_CHK_POWER:
> +		case ATA_CMD_SLEEP:
> +		case ATA_CMD_FLUSH:
> +		case ATA_CMD_FLUSH_EXT:
> +		case ATA_CMD_STANDBYNOW1:
> +			if (qc->tf.command == ATA_CMD_ID_ATA)
> +			{
> +				/* only fake the reply for IDENTIFY if it is from userspace */
> +				if (ata_tag_internal(qc->tag))
> +					break;
> +				sg_copy_from_buffer(qc->sg, 1, qc->dev->id, 2 * ATA_ID_WORDS);
> +			}
> +			/* fake reply to avoid waking drive */
> +			qc->flags |= ATA_QCFLAG_RTF_FILLED;
> +			qc->result_tf.nsect = 0;
> +			ata_qc_complete(qc);
> +			return;
> +		}
>  		link->eh_info.action |= ATA_EH_RESET;
>  		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
>  		ata_link_abort(link);

-- 
Damien Le Moal
Western Digital Research

