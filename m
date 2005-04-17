From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: VT8237 SATA + RAID
Date: Sun, 17 Apr 2005 12:56:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44.0504171239440.15967-100000@coffee.psychology.mcmaster.ca>
References: <4262384E.2090607@antar.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coriana6.CIS.mcmaster.ca ([130.113.128.17]:15819 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261366AbVDQQ4q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Apr 2005 12:56:46 -0400
In-Reply-To: <4262384E.2090607@antar.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ludwig Meyerhoff <ludwig@antar.de>
Cc: linux-ide@vger.kernel.org

> I know there are better solutions like RAID controllers with their own 
> microcontrollers,

the microcontroller is usually orders of magnitude slower than the host,
so "better" does not apply.  offloading parity makes a certain amount 
of sense, but it becomes nontrivial where you draw the line (if you have 
a parity engine, it's nice to have a substantial cache.  if you have a 
big cache, you have to add more smarts in managing it -> TCQ -> pretty
soon you have a full blown SAN raid controller (and the mediocre performance
that implies.)  I think it's mainly marketing pressure that drives people
away from the wisdom of simple-is-better.

> a solution which does not consist of a software-raid managed by the 
> kernel (I had some trouble with it when one of the two disks (RAID 1) 
> crashed - all data lost).

don't be silly - md raid is used in probably tens of millions of servers 
and is not flakey.

