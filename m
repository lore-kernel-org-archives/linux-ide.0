Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF823645D
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661536; cv=none; b=BRY9UTXxErlBcJfLAeEZfQ1H/hhsS92/YNIrKnVQsbUVg4tJm5LR6riFB0bGVm0bbeNR9LMcjr+ICvlSc7A3hXJ0q+M/Pa5RFzKkeTHudEjgUlskTtSdf7RssYWoC3Wovn8tuq4yYs1ZBYqRT+2NjYFBAwf2xfFa2cFcicyY3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661536; c=relaxed/simple;
	bh=7T8myRjc+Pb+0ETvJh08Jf9Ff806HceW3hb8Q1x/j6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Qz/PugmNNYlsGynjatUOfJ98+EZMYHLwEv3FVfq4hrOG5K0YllboXfjp4XNKCuNOtS4yVHgKGQuvKmpLpcg2DDD1jMlF04XF/P0apFSxjkaPnDUWPsLOCBpR+AB18IbQ0hbnXrccvpB40NB1y1eBD8FzgaPh66wd+wWzOdZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uum+u6Pg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uum+u6Pg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98BCC4CEF1;
	Tue,  2 Dec 2025 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764661535;
	bh=7T8myRjc+Pb+0ETvJh08Jf9Ff806HceW3hb8Q1x/j6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uum+u6Pg8UEO3DrnLNal+nADvZfzxb7CSpBlL63WhnsK0vXetr5Ny2s+i9NbGOF6p
	 2e1S4DYXWzfkXePjRuCjdNoKCmPdDTR40iAUrBK9jA06l3u6CDbLGvQ8ummVD1xZxA
	 yg22vYpd6TL4tiT1NX+0ktQsRnzRHjUfogF30/LNrB8T8/IaSrkv6TGOrTA5jzTEOP
	 l1ofO5cthOELMSV4i05yTXvZOCmCaSCoYBO+ZfHWwuxWNNC4IT9Jks7+ozzUL2GpOX
	 XlX37CssZcgZr10zJjeE/E70aN2qHQ8OK+RftG3E2i7UWDvidTTnocdXqMaTclAKIG
	 XaIv5G5ehs/6g==
Date: Tue, 2 Dec 2025 08:45:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Henry Tseng <henrytseng@qnap.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Kevin Ko <kevinko@qnap.com>, SW Chen <swchen@qnap.com>
Subject: Re: [PATCH v3] ata: libata: avoid long timeouts on hot-unplugged
 SATA DAS
Message-ID: <aS6ZHEdaeBeUg1t5@ryzen>
References: <20251201094622.1475358-1-henrytseng@qnap.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201094622.1475358-1-henrytseng@qnap.com>

On Mon, Dec 01, 2025 at 05:46:22PM +0800, Henry Tseng wrote:
> When a SATA DAS enclosure is connected behind a Thunderbolt PCIe
> switch, hot-unplugging the whole enclosure causes pciehp to tear down
> the PCI hierarchy before the SCSI layer issues SYNCHRONIZE CACHE and
> START STOP UNIT for the disks.
> 
> libata still queues these commands and the AHCI driver tries to access
> the HBA registers even though the PCI channel is already offline. This
> results in a series of timeouts and error recovery attempts, e.g.:
> 
>   [  824.778346] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
>   [  891.612720] ata8.00: qc timeout after 5000 msecs (cmd 0xec)
>   [  902.876501] ata8.00: qc timeout after 10000 msecs (cmd 0xec)
>   [  934.107998] ata8.00: qc timeout after 30000 msecs (cmd 0xec)
>   [  936.206431] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>   ...
>   [ 1006.298356] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
>   [ 1017.561926] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
>   [ 1048.791790] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
>   [ 1050.890035] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> 
> With this patch applied, the same hot-unplug looks like:
> 
>   [   59.965496] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
>   [   60.002502] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>   ...
>   [   60.103050] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> 
> In this test setup with two disks, the hot-unplug sequence shrinks from
> about 226 seconds (~3.8 minutes) between the Link Down event and the
> last SYNCHRONIZE CACHE failure to under a second. Without this patch the
> total delay grows roughly with the number of disks, because each disk
> gets its own SYNCHRONIZE CACHE and qc timeout series.
> 
> If the underlying PCI device is already gone, these commands cannot
> succeed anyway. Avoid issuing them by introducing
> ata_adapter_is_online(), which checks pci_channel_offline() for
> PCI-based hosts. It is used from ata_scsi_find_dev() to return NULL,
> causing the SCSI layer to fail new commands with DID_BAD_TARGET
> immediately, and from ata_qc_issue() to bail out before touching the
> HBA registers.
> 
> Since such failures would otherwise trigger libata error handling,
> ata_adapter_is_online() is also consulted from ata_scsi_port_error_handler().
> When the adapter is offline, libata skips ap->ops->error_handler(ap) and
> completes error handling using the existing path, rather than running
> a full EH sequence against a dead adapter.
> 
> With this change, SYNCHRONIZE CACHE and START STOP UNIT commands
> issued during hot-unplug fail quickly once the PCI channel is offline,
> without qc timeout spam or long libata EH delays.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Henry Tseng <henrytseng@qnap.com>

Thanks for the patch!

Since the merge window is already open, and since this is not a strict bug
fix, this will be queued up after v6.19-rc1 is out (targeting v7.0 / v6.20,
whichever Linus decides to name it).


Kind regards,
Niklas
