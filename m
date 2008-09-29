From: Tejun Heo <tj@kernel.org>
Subject: Re: One drive which perform frequent head unloads under Linux
Date: Mon, 29 Sep 2008 17:44:49 +0900
Message-ID: <48E09581.8010504@kernel.org>
References: <1222334079.13537.2.camel@frattaglia>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33829 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbYI2Iqi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 04:46:38 -0400
In-Reply-To: <1222334079.13537.2.camel@frattaglia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincenzo Ciancia <ciancia@di.unipi.it>
Cc: linux-ide@vger.kernel.org

Vincenzo Ciancia wrote:
> Hi, I own a toshiba m400 and I already had to replace a disk in less
> than one year (luckily, it was covered by warranty). I noticed that
> Load_Cycle_Count was indeed increasing. Using hdparm -B 255 fixes it,
> but also 254 seems to fix it (and I guess it is better to have some
> power management than none at all?). 
> 
> I am not subscribed to the list so if you need more information just ask
> me. I followed instructions at
> 
> http://ata.wiki.kernel.org/index.php/Known_issues#How_to_determine_whether_a_machine_has_this_problem

I just updated the page.  Can you please read the updated part (which is
in bold) and post how much the load cycle count increases per hour
without any adjustment?

Thanks.

-- 
tejun
