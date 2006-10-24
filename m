From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SATA driver issues?
Date: Tue, 24 Oct 2006 11:55:37 +1000
Message-ID: <1161654938.10524.517.camel@localhost.localdomain>
References: <2F0FC2A92C0B154BB406D5E74CB3E6930336BD5F@3putt.int.lantronix.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:14021 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030184AbWJXCBG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Oct 2006 22:01:06 -0400
In-Reply-To: <2F0FC2A92C0B154BB406D5E74CB3E6930336BD5F@3putt.int.lantronix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Danny Sung <dsung@lantronix.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, 2006-10-23 at 18:27 -0700, Danny Sung wrote:
> Hi guys, I'm just writing to report some strange problems I'm seeing on
> an IBM system with SATA drives.  I'm following the comments in the
> sata_svw.c file, so hopefully I'm writing the correct people.
> 
> First my configuration:
> 
>  - IBM 7969AC1 - xSeries 326m  (2x dual core AMD Opteron 285, 2GB RAM)
>  - Fedora Core 5, kernel 2.6.18  (package 2.6.18-1.220.fc5smp)
>    I specifically chose to run the 32-bit version of Fedora as well.
>  - IBM BIOS has the latest firmware from IBM (which did resolve the
> issue of the system crashing).
>  - Hard drives are 2x WD2500JS's
>  - This particular server is using the BCM5785 (aka HT-1000) broadcom
> chipset

The HT1000 is using a frodo SATA cell ? (me doesn't know for sure :)

What is the lspci output ?

Ben.


