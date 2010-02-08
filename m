From: Tejun Heo <tj@kernel.org>
Subject: Re: Corrupt data - RAID sata_sil 3114 chip
Date: Mon, 08 Feb 2010 11:31:46 +0900
Message-ID: <4B6F7792.1070902@kernel.org>
References: <4B630914.9010503@fs.ei.tum.de> <4B6338E2.1040507@gmail.com> <4B6CE7E0.1060209@kernel.org> <4B6D87DF.6030305@buttersideup.com> <4B6EE5D4.1010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42699 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414Ab0BHCZS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Feb 2010 21:25:18 -0500
In-Reply-To: <4B6EE5D4.1010907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tim Small <tim@buttersideup.com>, "Ulli.Brennenstuhl" <Ulli.Brennenstuhl@fs.ei.tum.de>, linux-ide@vger.kernel.org

On 02/08/2010 01:09 AM, Robert Hancock wrote:
> It's something to check, yes. It would be somewhat surprising if that
> were occurring - detected PCI parity errors should cause a target abort
> and cause a transfer failure, not silent data corruption. But again, on
> an old VIA chipset, for this to be handled improperly wouldn't be
> shocking :-)

Oh... some via pci bridges are known to ignore PCI parity errors.  It
will just happily proceed with corrupt data.

-- 
tejun
