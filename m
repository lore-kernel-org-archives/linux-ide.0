From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Mon, 13 Jun 2011 12:48:56 +0200
Message-ID: <20110613104856.GC16021@htj.dyndns.org>
References: <20110426155229.GM878@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C77554C91@gretna.indigovision.com>
 <20110430140109.GJ29280@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C777089B2@gretna.indigovision.com>
 <20110525094127.GF10146@htj.dyndns.org>
 <4DF20E03.9030502@teksavvy.com>
 <20110610140155.GJ15235@htj.dyndns.org>
 <4DF25526.9010800@teksavvy.com>
 <20110611121957.GA7980@mtj.dyndns.org>
 <4DF4F30B.70702@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60971 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1FMKtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2011 06:49:01 -0400
Content-Disposition: inline
In-Reply-To: <4DF4F30B.70702@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Bruce Stenning <b.stenning@indigovision.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello,

On Sun, Jun 12, 2011 at 01:10:35PM -0400, Mark Lord wrote:
> On 11-06-11 08:19 AM, Tejun Heo wrote:
> > On Fri, Jun 10, 2011 at 01:32:22PM -0400, Mark Lord wrote:
> >>> I don't think it would be wise to include the patch for -stable tho.
> >>> It's not a regression fix and has some possibility of introducing
> >>> regressions, so....
> >>
> >> Not a regression fix?  Excuse me?
> >> SATA hotplug always used to work fine,
> >> and is more or less essential to reboot-free operations.
> > 
> > There are two separate patches.  One is a fix which got pushed to
> > Linus by Jeff early yesterday.  The other changes behavior which has
> > been like that since the beginning of EH.  The former is marked
> > properly w/ -stable.  The latter shouldn't be in -stable.
> 
> Peachy.  Got links for each of those?
> I may try them with the sata_sil board that was having issues earlier.

The fix is

 http://article.gmane.org/gmane.linux.ide/49615

and the behavior change is

 http://article.gmane.org/gmane.linux.ide/49613

-- 
tejun
