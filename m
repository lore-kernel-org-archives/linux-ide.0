Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840151C21
	for <linux-ide@vger.kernel.org>; Thu,  8 Feb 2024 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435799; cv=none; b=E73Ug2b3zY6BBAeu4pxTxVGKQ0TmyicleXHEwfGweXomsPQiK7l99tjCkiysi8ukN9euizcShi6D5xSdMnL54Yxl7H6tpGY4rmtdxnM9T7dYbNdy2dMVvAn3ABFSZeYw4+X5QbQUUods6KxUsukrH+8M6LvttHuzlZIE2vJtT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435799; c=relaxed/simple;
	bh=YANM6bP9MybS0vsLK2xK4zy7V5kxASvnrUHk7xerWZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/LysBEm8iytri1YQsQXJITarM7sA61ozKkb8arm8rdFWk9hdTOuoIM/O1mGMKxD1nVqKu6oikUUd+UdoANxvdqS45bI4UxQtViHZey07QmXq1y4HbGi2XnJoyNDefU4FiyWN3gmtUwiUYpfaT8OQbiWH1LNst6cHWTPt0dnXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGgf3N2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGgf3N2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB7EC433C7;
	Thu,  8 Feb 2024 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707435798;
	bh=YANM6bP9MybS0vsLK2xK4zy7V5kxASvnrUHk7xerWZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SGgf3N2O2lPr2qE1JiDmKPPPrgd8Q+XLvn8aUHpFfqqLTc2DOwHpwcjGAL+miRWGe
	 G6A3j1i2TLHZdLIRkgnsrBkeU8IicjO+7eBzX/KMsGpX4EBx/Z6sxB9+Mxm3TlXaIK
	 sMT5Jd8BvC/KQmd3FXzH5t9rZ/zCpKkaX2rrga2uMvkVfyupANNJonReqK5JX1Z2zm
	 i+OiPvZK36QPRG8MJtp9J3CKt/2zKED53Fz2EkEH6JbPPNS/wQdVASkJeuJ+dOfY0+
	 GOqPZK1oi4e8hcRXBjTQFw+ToRVdc8+xKjmr7pUZWCdLhUqh1MucT/s2KKaEAJz65P
	 F9mfyy0XHqRuA==
Message-ID: <5692a616-0cc3-4a49-880f-6596bff99c79@kernel.org>
Date: Fri, 9 Feb 2024 08:43:16 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] drop low power policy board type
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>,
 linux-ide@vger.kernel.org
References: <20240206211352.1664816-1-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240206211352.1664816-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 06:13, Niklas Cassel wrote:
> The series is based on top of:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next
> 
> 
> Hello all,
> 
> This revives a patch sent out almost two years ago from Mario Limonciello:
> https://lore.kernel.org/linux-ide/20220524170508.563-1-mario.limonciello@amd.com/T/#u
> 
> The reason why we did not merge it back then, is because LPM and hotplug
> events are mutually exclusive.
> 
> The difference with this series compared to what was sent out back then:
> I've added a patch that checks if the port is external, i.e. either
> hotplug capable or eSATA. For external ports, we never enable LPM, as
> that will break hotplug.
> 
> For ports that do not advertise themselves as external (typically laptops),
> we set the LPM policy as requested.
> 
> This matches how Microsoft Windows does things, see:
> https://studylib.net/doc/10034428/esata---microsoft-center
> 
> Thanks to Werner Fischer for suggesting something like this at last year's
> ALPSS conference.
> 
> There might of course be some platform firmware that e.g. incorrectly marks
> its port as internal, even though it is external, but if we find any such
> platforms we will need to deal with them using quirks.
> 
> 
> Also note that we even if the user requested a certain policy, there is
> no guarantee that he will get all the features for that policy, see:
> https://github.com/torvalds/linux/blob/master/drivers/ata/libata-sata.c#L403-L414
> 
> However, I'd rather we not try to map all the combinations of
> partial/slumber/devsleep in to a single policy represented by a single
> integer, thus I do not try to "change" the requested policy.
> The user will get all the features that are included in the requested
> policy AND supported by the HBA.
> 
> Another difference (compared to an earlier version of Mario's series)
> is that we do not try to change the default CONFIG_SATA_MOBILE_LPM_POLICY
> value from 0 to 3, it will continue to be 0.
> If you really don't want LPM even if your HBA supports it, and your port
> is internal, one option is to leave the Kconfig set to the default value.
> 
> Damien: considering that the Intel VMD + ahci_intel_pcs_quirk() bug turned
> out to have nothing to do with LPM, it was simply the fact that the
> ahci_intel_pcs_quirk() was only applied if there was an explicit entry in
> ahci_pci_tbl. So since that bug is totally unrelated to LPM, I no longer
> think that this series need to wait for a fix for that bug.
> 
> 
> Link to v1:
> https://lore.kernel.org/linux-ide/20240201161507.1147521-1-cassel@kernel.org/
> 
> Changes since v1:
> -Picked up tags from Damien.
> -Moved the comment in front of ahci_mark_external_port() to inside the
>  function.
> -Modified the comment in patch 4/5 to more clearly state hotplug removal
>  events.
> -Rewrote the commit message for patch 4/5 to be more detailed.

I tested the series on an AMD machine which has AMD AHCI (FCH SATA Controller
[AHCI mode] (rev 51), PCI IDs: 1022:7901) and also a Marvell 88SE9128 PCIe SATA
adapter (PCI ID 1b4b:9128).

SATA Hotplug for the Marvell adapter works out of the box using 6.8-rc3 but
*does not work* at all for the AMD AHCI (not even link down events are seen
when a drive is pulled from a front loading slot).

Applying the series on top of 6.8-rc3, hotplug with the Marvell adapter
continues to work just fine and the AMD AHCI hotplug also finally works !
When pulling a drive I see link down events and re-plugging the drive I see:

[  156.984966] ata20: found unknown device (class 0)
[  157.148919] ata20: softreset failed (device not ready)
[  162.922094] ata20: link is slow to respond, please be patient (ready=0)
[  167.193191] ata20: found unknown device (class 0)
[  167.357190] ata20: softreset failed (device not ready)
[  168.701232] ata20: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  168.712580] ata20.00: ATA-12: ...
...
[  168.829910] sd 19:0:0:0: [sdj] Write Protect is off
[  168.835403] sd 19:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[  168.835584] sd 19:0:0:0: [sdj] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[  168.845872] sd 19:0:0:0: [sdj] Preferred minimum I/O size 4096 bytes
[  170.601826] sd 19:0:0:0: [sdj] Attached SCSI removable disk

So this seems all good to me. Feel free to add:

Tested-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

