From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: scary message 'failed to recover some devices ... retrying'
	HPT370
Date: Tue, 31 Oct 2006 19:22:46 +0000
Message-ID: <1162322567.11965.86.camel@localhost.localdomain>
References: <20061031185921.GA3636@amd64.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423808AbWJaTSz@vger.kernel.org>
In-Reply-To: <20061031185921.GA3636@amd64.of.nowhere>
Sender: linux-kernel-owner@vger.kernel.org
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Ar Maw, 2006-10-31 am 19:59 +0100, ysgrifennodd jurriaan:
> ata11.00: ATA-6, max UDMA/100, 488397168 sectors: LBA48
> ata11.00: ata11: dev 0 multi count 16

Found the master happily

> ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata11: failed to recover some devices, retrying in 5 secs
> ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata11: failed to recover some devices, retrying in 5 secs
> ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata11: failed to recover some devices, retrying in 5 secs

Slave probing is noisy and annoying right now because it tries too hard
but this fine (unless oyuhave a slave device)

Thanks for the report. I'll review the drive detect for the chip but I
suspect it just needs to switch to the polling probe.
