From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA timeouts on two disks
Date: Mon, 21 Jan 2008 16:47:58 +0900
Message-ID: <47944E2E.2070300@gmail.com>
References: <3afbacad0801121656u7318de7l57ba5064da259f3f@mail.gmail.com>	 <18313.65287.290482.369023@harpo.it.uu.se> <3afbacad0801190822v19be782er3d48cbc94293e262@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:26651 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbYAUHsJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 02:48:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3542119wah.23
        for <linux-ide@vger.kernel.org>; Sun, 20 Jan 2008 23:48:08 -0800 (PST)
In-Reply-To: <3afbacad0801190822v19be782er3d48cbc94293e262@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim MacBaine <jmacbaine@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Jim MacBaine wrote:
> On Jan 13, 2008 1:07 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> 
>> The fact that the problems occur on different disks on
>> different controllers driven by different drivers indicates
>> that it's not a disk, controller, or driver problem.
>>
>> I strongly suspect an underdimensioned or failing PSU.
> 
> Thanks a lot for your clues.
> 
> I bought a new PSU on Monday and didn't get any new disk failures for
> days.  But last night the same time-outs occurred again on two disks.
> I guess I will try to replace the motherboard including the two SATA
> controllers next.

If you still have the old PSU lying around, please try to power one of
the failing drive with the old PSU.  Just leave everything else as-is,
power-up old PSU by itself as described in the following web page and
connect only one of the failing drive to the old PSU.

  http://modtown.co.uk/mt/article2.php?id=psumod

And see whether the problem continues and if so on which drives.
Connecting SATA drives to separate power is completely safe even if they
don't have common ground because SATA connection never directly connect
to each other.

-- 
tejun
