From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date: Mon, 6 Jul 2009 16:57:59 +0200
Message-ID: <200907061658.00936.bzolnier@gmail.com>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <200907031508.47891.bzolnier@gmail.com> <1246635096.16890.6.camel@falcon>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:53964 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbZGFOvs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jul 2009 10:51:48 -0400
In-Reply-To: <1246635096.16890.6.camel@falcon>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: wuzhangjin@gmail.com
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Etienne Basset <etienne.basset@numericable.fr>, David Miller <davem@davemloft.net>, rjw@sisk.pl, linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

On Friday 03 July 2009 17:31:36 Wu Zhangjin wrote:
> Hi,
> 
> > OK, I see another gotcha added by recent changes, we need to explicitly
> > initialize rq_in_flight variables now.  Revised patch below..
> > 
> 
> Sorry, STD also not work. if apply this patch, the same problem as not
> apply it, it stopped at:
> 
> ...
> PM: Crete hibernation image:
> PM: Need to copy ... pages
> PM: Hibernation image created ...
> 
> I think it's better to revert this commit:
>  a1317f714af7aed60ddc182d0122477cbe36ee9b ("ide: improve handling of
> Power Management requests")
 
I completely agree and I've already requested this a week ago
(this commit was not meant for going straight to -rc tree anyway).
