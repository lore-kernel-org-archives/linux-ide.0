From: listmail <listmail@triad.rr.com>
Subject: debian shutdown info
Date: Sat, 20 Oct 2007 02:18:16 -0400
Message-ID: <47199DA8.6000605@triad.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:36458 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbXJTGd4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Oct 2007 02:33:56 -0400
Received: from linserv ([65.188.228.203]) by hrndva-omta01.mail.rr.com
          with ESMTP
          id <20071020061757.OPVA4050.hrndva-omta01.mail.rr.com@linserv>
          for <linux-ide@vger.kernel.org>; Sat, 20 Oct 2007 06:17:57 +0000
Received: from gamehub.localnet
	([192.168.0.124] helo=[127.0.0.1] ident=HydraIRC)
	by linserv with esmtp (Exim 4.67)
	(envelope-from <listmail@triad.rr.com>)
	id 1Ij7em-00018Q-Nm
	for linux-ide@vger.kernel.org; Sat, 20 Oct 2007 02:17:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I was still getting this message on Debian sid w/kernel 2.6.22.6 and I 
could hear my drive spin back up before the PC went completely off.  
This was the fix
which was a small edit on the /etc/init.d/halt script.  It worked on two 
boxes.

http://www.linuxquestions.org/questions/debian-26/disk-might-not-be-spun-down-properly.-update-shutdown-utility-583307/
