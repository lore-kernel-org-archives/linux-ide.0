From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Sil 3512 and Seagate ST3802110AS
Date: Fri, 11 Aug 2006 12:04:44 +0200
Message-ID: <20060811100444.GB31504@harddisk-recovery.com>
References: <455FCE13-2A0E-4BBE-8D1B-45C02C3C1C69@purplevisiontech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:39239 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751088AbWHKKEq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Aug 2006 06:04:46 -0400
Content-Disposition: inline
In-Reply-To: <455FCE13-2A0E-4BBE-8D1B-45C02C3C1C69@purplevisiontech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harsha Padmanabha <harsha@purplevisiontech.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Fri, Aug 11, 2006 at 02:00:49PM +0530, Harsha Padmanabha wrote:
> I am trying to get sata_sil running on a MPC8349(PPC) board, I runto  
> the following errors. I cannot upgrade my kernel to the latest one  
> since most of my changes for MPC8349 to work  are for 2.6.11.
> 
> 1) How can i patch the latest release of libata for 2.6.11 without  
> having to change to 2.6.17

With a lot of work.

> 2) I have tried SIL 3112 card with the same results

What same results?

> 3) I have also tried different hard drives like samsung and WDC
> 
> Please let me know what i can do to get this running.

Upgrade to 2.6.17. Because you are familiar with your own changes, it
will be a lot less work porting them from 2.6.11 to 2.6.17 than to port
an unfamiliar piece of code like libata back to 2.6.11.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
