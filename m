From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: sata_mv @ asus PSCH-SR/SATA doesnt work
Date: Thu, 19 Jan 2006 23:38:02 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0601192333300.23973-100000@kenzo.iwr.uni-heidelberg.de>
References: <200601191823.01254.opa@nsib.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:4045 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1161380AbWASWj2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jan 2006 17:39:28 -0500
In-Reply-To: <200601191823.01254.opa@nsib.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pasha <opa@nsib.ru>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Thu, 19 Jan 2006, Pasha wrote:

> I has asus PSCH-SR/SATA with aic-8110 RAID chip

Some of my previous results posted on this list were obtained on
exactly this type of mainboard.

> sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via MSI

You need to disable MSI in the kernel config and recompile.

--
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

