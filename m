From: Marc Bejarano <list.linux-ide@beej.org>
Subject: Fwd: Re: Silicon Image 3124 problems with Norco DS-1220
  (Sil3726 port multipliers?)
Date: Tue, 27 Feb 2007 18:43:00 -0500
Message-ID: <200702272343.l1RNh7tY018807@tenet.verdasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tenet.verdasys.com ([69.20.4.32]:44963 "EHLO tenet.verdasys.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbXB1ALb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Feb 2007 19:11:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregory Youngblood <gyoungblood@incentivelogic.com>
Cc: linux-ide@vger.kernel.org

Gregory Youngblood wrote:
>I'm seeing several problems with a Silicon Image 3124 and Norco 
>DS-1220 external sata shelf with two Silicon Image 3726 port 
>multipliers and 8 500gb 7200.10 Seagate sata hard drives. The 
>hardware is known to be good. Or at least the Dell server is. The 
>only new hardware added to this server is the Norco DS-1220, Norco 
>4618 (Sil3124) controller, and the 8 drives. These problems are 
>causing file operations with remote servers (via Samba) to fail 
>intermittently.
>
>Any advice or help to get this working reliably is appreciated.

i don't have advice that you'll like ;)  if you want to get this 
working ASAP, give in and taint your vendor-supplied kernel with the 
vendor-supplied driver:
<http://www.siliconimage.com/docs/si3124r5_RHEL43_64bit_v1090_driver_and_GUI.tar.gz>http://www.siliconimage.com/docs/si3124r5_RHEL43_64bit_v1090_driver_and_GUI.tar.gz

works fine until you hit errors (find a working drive firmware and 
stick with it) and won't consume ridiculous amounts of memory until 
you put more than two controllers in a system.  oh yeah... no hotplug 
or PM either :(

otherwise, find someone who wants to beat tejun's existing 
PMP-enabled driver into submission.  i'll buy you a beer if you 
succeed in that :D  like you, i've had little luck with it in it's 
current state.

good luck,
marc 

