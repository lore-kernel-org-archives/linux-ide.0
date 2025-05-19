Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AF27511E;
	Mon, 19 May 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647091; cv=none; b=Fc0asa0dhpDOIE0MC1vWRSjjb292c3/f86fMSkbb/v3YLEG35TdB2kIWBA1y1FMWr8NmN0ICZr8Spltj17f66NNWyJVDl6LXb24dDbRh/KgeV/5yvdqoSeHa58UG6NDKwH1PcSK2AeTc5hNCEJcAlWjkO4ca0P7tPZ9Q1/i4b3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647091; c=relaxed/simple;
	bh=FXdfPhdfLVoRwDBosojS9gg4O/gtTxeDHKm6qIIKGEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brOIFx3m61vZBx7+J8ZpaPfi3BqnqduvGqQk7ep9x/Iim5V1esf1pxB5KfCBE5xf1zIinlls1ziz9WtiJkaSSpSQm0LaGdNRA+vicx2gUDXooQvvZgDtws38+06K0aR4DUgtzf1L4bDnkQp7IpepO47WJXqvNa06cda3uIvXkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXhxJAlz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXhxJAlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62211C4CEED;
	Mon, 19 May 2025 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747647090;
	bh=FXdfPhdfLVoRwDBosojS9gg4O/gtTxeDHKm6qIIKGEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXhxJAlzGJpMsG1OOb5FTHQQMMUBanDJTGOKz81MVpyJY7dDx2P19hv9QsB5+I61O
	 lARLyHGnr+cyaMu4t46nnd7UKKq3HwR0LZBz+AgqsIJ0GzveHE6UPe5l9XO2ljfjve
	 DaRrgoP1Zk7FnR25Po6imZPw1JY6oIeToNgOVbIRsqMeWPoW/WyKKWiXAtbgwd+i/G
	 4BqfrsOyqbBG87GrgcbSI6xUWkyUkbCbFuhcQDfCMKws35SJiu0/srmPJUdnVBCZ0g
	 udEmC1kL4Suoq2qEQnZEQK6jKwZT4S1A2vf45zfvm5F2rQwTC3WrjG8pLWFmO/kVtF
	 2pLfBQ3bzvnHQ==
Date: Mon, 19 May 2025 11:31:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Joj Loj3 <jojloj3@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] pata_jmicron - JMB368-based IDE to PCIe adapters capped at
 extremely slow speeds
Message-ID: <aCr6bm7xyBXiF8-G@ryzen>
References: <CAOnE0bQBVS2hz9Mbv+HFLSYUiuTcJJ=A6UqVrhP8Sgf_muMaCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnE0bQBVS2hz9Mbv+HFLSYUiuTcJJ=A6UqVrhP8Sgf_muMaCg@mail.gmail.com>

Hello Joj Loj3,

On Sat, May 17, 2025 at 02:18:33PM -0400, Joj Loj3 wrote:
> Apologies for the previous email, which was not formatted as
> plaintext. I have fixed this for this email.
> 
> Dear Maintainers,
> 
> Tested on several kernels, including the latest master at time of
> testing ( 6.15.0-0.rc5.250509g9c69f8884904.47.fc43.x86_64 ),
> JMB368-based IDE to PCIe adapters are capped at extremely slow speeds,
> regardless of whether the device attached is capable of much higher
> ones. This issue exists OOTB on Windows as well, but is fixed via
> installing the proper drivers, see
> http://forum.redump.org/topic/59287/fix-for-pex2ide-jmicron-36x-based-pci-adapters-on-windows-1011/
> for more information. I have tested Windows on the same machine and
> confirmed that the issue is fixed once I have installed the proper
> drivers.
> 
> Please let me know what additional info is necessary. This is my first
> time submitting a kernel bug, and I'm not sure what extra information
> might be needed.

I'm not sure what you want us to do with the information that you have
provided.

The performance with pata_jmicron is bad, on multiple kernel versions.
(Which is the oldest kernel version you tested?)

The fact that the default Windows driver has the same problem does not
help us that much, unless you can figure out what the "good" driver is
doing that the bad one is not.

You seem to have an ATAPI device using UDMA/66:
[    3.315037] ata7.00: ATAPI: PLEXTOR DVDR   PX-716A, 1.11, max UDMA/66

There have been some reports for other PATA drivers (e.g. pata_via) to
force PIO for ATAPI devices:
https://lore.kernel.org/linux-ide/20250519085508.1398701-1-tasos@tasossah.com/T/#u

Have you tried forcing other transfer modes?
e.g. by adding 'libata.dma=0' on the kernel command line.


Kind regards,
Niklas

> 
> Relevant output from dmesg:
> [    3.155555] scsi host6: pata_jmicron
> [    3.159374] scsi host7: pata_jmicron
> [    3.159457] ata7: PATA max UDMA/100 cmd 0xd010 ctl 0xd020 bmdma
> 0xd000 irq 28 lpm-pol 0
> [    3.159461] ata8: PATA max UDMA/100 cmd 0xd018 ctl 0xd024 bmdma
> 0xd008 irq 28 lpm-pol 0
> [    3.204963] FDC 0 is a post-1991 82077
> [    3.229154] usb-storage 1-3:1.0: USB Mass Storage device detected
> [    3.230081] scsi host8: usb-storage 1-3:1.0
> [    3.230253] usbcore: registered new interface driver usb-storage
> [    3.234360] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95754) rev
> 5784100] (PCI Express) MAC address 2c:27:d7:2d:99:f4
> [    3.234367] tg3 0000:01:00.0 eth0: attached PHY is 5784
> (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
> [    3.234370] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0]
> MIirq[0] ASF[0] TSOcap[1]
> [    3.234373] tg3 0000:01:00.0 eth0: dma_rwctrl[76180000] dma_mask[64-bit]
> [    3.315037] ata7.00: ATAPI: PLEXTOR DVDR   PX-716A, 1.11, max UDMA/66
> [    3.319542] scsi 6:0:0:0: CD-ROM            PLEXTOR  DVDR   PX-716A
>   1.11 PQ: 0 ANSI: 5
> [    3.362459] sr 6:0:0:0: [sr1] scsi3-mmc drive: 40x/40x writer cd/rw
> xa/form2 cdda tray
> [    3.389254] sr 6:0:0:0: Attached scsi CD-ROM sr1
> [    3.389402] sr 6:0:0:0: Attached scsi generic sg2 type 5
