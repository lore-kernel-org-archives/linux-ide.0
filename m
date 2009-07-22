From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA II NCQ and multi-port support for ICH7
Date: Wed, 22 Jul 2009 12:04:02 -0600
Message-ID: <4A675492.9060106@gmail.com>
References: <0KN6003ZATOVGH70@vms173017.mailsrvcs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:43045 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZGVSB5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jul 2009 14:01:57 -0400
Received: by ewy26 with SMTP id 26so418551ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 11:01:56 -0700 (PDT)
In-Reply-To: <0KN6003ZATOVGH70@vms173017.mailsrvcs.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dhdurgee@verizon.net
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 07/22/2009 07:15 AM, dhdurgee@verizon.net wrote:
> I have recently purchased an Areca ARC-5020 external eSATA II RAID to
> connect to my system.  This unit supports ICH NCQ and multi-port for
> multiple volumes.  I have connected it to my Intel DG41TY mainboard, which
> has the Intel 82801GB I/O Controller Hub (ICH7), but I find I am only
> seeing the first volume and the unit shows NCQ is inactive.

...

> So NCQ is detected on the RAID unit but is not enabled and only one of the
> two volumes is being seen.  Am I missing something that needs to be
> enabled for the driver to support the advanced features?  Is my
> configuration loading the proper driver?  If not, how can I load it?

The SATA controller is in the legacy PIIX mode which doesn't support 
most SATA-specific features. You need to switch it into AHCI mode 
(should be a BIOS setting for it somewhere) and then the ahci driver 
will get used instead of ata_piix.
