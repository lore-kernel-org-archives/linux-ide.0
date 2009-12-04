From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata-mv: Unable to stop eDMA
Date: Thu, 03 Dec 2009 18:25:45 -0600
Message-ID: <4B185709.2030700@gmail.com>
References: <20091203191232.GA5382@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36568 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZLDAZl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 19:25:41 -0500
Received: by gxk26 with SMTP id 26so1761389gxk.1
        for <linux-ide@vger.kernel.org>; Thu, 03 Dec 2009 16:25:48 -0800 (PST)
In-Reply-To: <20091203191232.GA5382@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-ide@vger.kernel.org, saeed@marvell.com, mlord@pobox.com, mail@g-radtke.name, avbidder@fortytwo.ch

On 12/03/2009 01:12 PM, Martin Michlmayr wrote:
> Two users of Debian on the QNAP TS-419P have seen the following
> "Unable to stop eDMA" error in dmesg.  Rebooting makes the problem go
> away.  Can someone explain what this problem is about and whether this
> might be a bug in the kernel?
>
> The QNAP TS-419P uses the Marvell Kirkwood SoC and offers 4 SATA ports
> via an 88SX7042 chip connected via PCIE (the SATA on the SoC is used
> for 2 eSATA ports).
>
> [  673.000000] ata1: Unable to stop eDMA
> [  673.100000] ata1.00: exception Emask 0x52 SAct 0x1 SErr 0xffffffff action 0xe frozen
> [  673.100000] ata1: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt PHYRdyChg PHYInt
> CommWake 10B8B Dispar BadCRC Handshk LinkSeq TrStaTrns UnrecFIS DevExch }
> [  673.100000] ata1.00: cmd 60/08:00:6e:b6:34/00:00:03:00:00/40 tag 0 ncq 4096 in
> [  673.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
> [  673.100000] ata1.00: status: { DRDY }
> [  673.100000] ata1: hard resetting link

The SError being set to all 1s suggests something strange has happened, 
like the hardware going cuckoo and returning PCI master aborts..
