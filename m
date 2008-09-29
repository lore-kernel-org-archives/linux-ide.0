From: Vincenzo Ciancia <ciancia@di.unipi.it>
Subject: Re: One drive which perform frequent head unloads under Linux
Date: Mon, 29 Sep 2008 14:18:46 +0200
Message-ID: <1222690726.26716.11.camel@frattaglia>
References: <1222334079.13537.2.camel@frattaglia>
	 <48E09581.8010504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from horus.di.unipi.it ([131.114.3.13]:34702 "EHLO
	mailserver.di.unipi.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751596AbYI2MTH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 08:19:07 -0400
In-Reply-To: <48E09581.8010504@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On lun, 2008-09-29 at 17:44 +0900, Tejun Heo wrote:
> Vincenzo Ciancia wrote:
> > Hi, I own a toshiba m400 and I already had to replace a disk in less
> > than one year (luckily, it was covered by warranty). I noticed that
> > Load_Cycle_Count was indeed increasing. Using hdparm -B 255 fixes it,
> > but also 254 seems to fix it (and I guess it is better to have some
> > power management than none at all?). 
> > 
> > I am not subscribed to the list so if you need more information just ask
> > me. I followed instructions at
> > 
> > http://ata.wiki.kernel.org/index.php/Known_issues#How_to_determine_whether_a_machine_has_this_problem
> 
> I just updated the page.  Can you please read the updated part (which is
> in bold) and post how much the load cycle count increases per hour
> without any adjustment?

The problem is that now I don't know what is the default (I also found
no way to read the -B setting with hdparm). I tried with hdparm -B 128
which seems adviced by many for laptops, and I get 130 cycles per hour. 

Vincenzo Ciancia

