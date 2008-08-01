From: Tejun Heo <tj@kernel.org>
Subject: Re: possible data corruption on ICH8 or WD raptor
Date: Sat, 02 Aug 2008 00:36:06 +0900
Message-ID: <48932D66.10700@kernel.org>
References: <0b8b01c8e5fb$65ed9480$0400a8c0@dcccs> <48929113.4020402@kernel.org> <037e01c8f3c2$f81c5330$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60096 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbYHAPgc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 11:36:32 -0400
In-Reply-To: <037e01c8f3c2$f81c5330$0400a8c0@dcccs>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Janos Haar <janos.haar@netcenter.hu>
Cc: linux-ide@vger.kernel.org

Janos Haar wrote:
>> You're getting PHY event on flush which is a pretty strong indication
>> that you're having power problem.  The disk goes out to transfer data in
>> its buffer to the platter and draws more power from the cable.  For some
>> reason, power is not maintained properly.  Disk checks out momentarily
>> causing the PHY event and losing the data in its buffer.  Try to connect
>> the harddrive to a separate PSU and see whether the problem goes away.
> 
> Thank you for the answer.
> 
> Now, this server is a productive syetem, and runs an important application.
> The problem generally exists, but looks like comes only when i am
> testing the transfer with big files.
> (the application does not do that)
> 
> About the power:
> This PC have one 650W Chieftech PS, 1 quad core cpu, and 6 hdd.
> I have previously measured the power current on the line, and the PC
> uses only 100-120W on peak.
> 
> The problem only comes on the 4 raptor hdd, and this drive only uses
> each 6W. (from the documentation).
> 
> It is hard to try separate PS or something hw solution.
> Additionally, generally i think it is not power issue, i am 90% sure.

Don't be too sure.  Power problems seem pretty common.  We (or rather I)
often suggest ruling out power problem first and often see unexpectedly
high portion of weird problems actually are caused by power.  And in
most of those cases, the wattage or brand printed on the PSU didn't mean
much.

> Are you sure this can not be software issue?
> If you say yes, i will go into the server room, and will try another ps
> anyway....

No, I'm not sure at all it can't be a software issue.  What I know are...

* FLUSH is one of the less likely commands which can trigger state
machine or transfer logic problem.  It's a command without any data.
Pretty difficult to get that wrong while getting others correct.

* Without ruling power problem out, debugging is really difficult as
power problems could manifest in unpredictable ways.  Plus, ruling out
power problem isn't too difficult.  Just hook up a separate PSU and
connect problematic hard drives to it.

* For some reason, we've been seeing good portion of weird link related
or data corruption problems following timeout or phy event turn out to
be power related ones.  I get the link problems as serial highspeed
links are highly susceptible to interferences.  I don't know why
suddenly there seemingly are more machines where disk looses data due to
power instability.  Maybe SATA made it cheap and easy to hook up more
disks to a machine.  Maybe those multi-lane power supplies just suck.  I
don't know.

If you can't hook up a separate PSU, can you please run "smartctl -a
/dev/sdX" right after boot and again after the phy error occurs and
report the results?

-- 
tejun
