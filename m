From: Tejun Heo <tj@kernel.org>
Subject: Re: One drive which perform frequent head unloads under Linux
Date: Tue, 30 Sep 2008 23:17:29 +0900
Message-ID: <48E234F9.9050509@kernel.org>
References: <1222334079.13537.2.camel@frattaglia>	 <48E09581.8010504@kernel.org> <1222690726.26716.11.camel@frattaglia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50118 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbYI3OSz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 10:18:55 -0400
In-Reply-To: <1222690726.26716.11.camel@frattaglia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincenzo Ciancia <ciancia@di.unipi.it>
Cc: linux-ide@vger.kernel.org

Vincenzo Ciancia wrote:
> On lun, 2008-09-29 at 17:44 +0900, Tejun Heo wrote:
>> Vincenzo Ciancia wrote:
>>> Hi, I own a toshiba m400 and I already had to replace a disk in less
>>> than one year (luckily, it was covered by warranty). I noticed that
>>> Load_Cycle_Count was indeed increasing. Using hdparm -B 255 fixes it,
>>> but also 254 seems to fix it (and I guess it is better to have some
>>> power management than none at all?). 
>>>
>>> I am not subscribed to the list so if you need more information just ask
>>> me. I followed instructions at
>>>
>>> http://ata.wiki.kernel.org/index.php/Known_issues#How_to_determine_whether_a_machine_has_this_problem
>> I just updated the page.  Can you please read the updated part (which is
>> in bold) and post how much the load cycle count increases per hour
>> without any adjustment?
> 
> The problem is that now I don't know what is the default (I also found
> no way to read the -B setting with hdparm). I tried with hdparm -B 128
> which seems adviced by many for laptops, and I get 130 cycles per hour. 

APM setting is not persistent and BIOS probably programs it during boot,
so just removing any script you added and doing a cold reboot should
give you the default configuration.

-- 
tejun
