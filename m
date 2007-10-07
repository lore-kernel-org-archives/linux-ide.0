From: "Marc Roos" <marc@roosit.nl>
Subject: Promise sata disc sort order
Date: Sun, 7 Oct 2007 20:08:19 +0200
Message-ID: <200710071808.l97I8F0s029722@web1.roosit.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 2122619320.roosit.nl ([212.26.193.20]:42841 "EHLO
	web1.roosit.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbXJGS3T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 14:29:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


Jeff,

Is there a way to bind the sd dives to the sata ports instead of available
harddrives? 

For instance 

Sda is port0 of sata controler0
Sdb is port1 of sata controler0
Sdc is port2 of sata controler0
Sdd is port3 of sata controler0

If the disk on port2 fails and the system is rebooted. I want the disk on
port3 still be available under sdd and not changing to sdc.


Regards,
Marc.


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -. 
Roos IT BV
the Netherlands 

t:  +31 (0)20 - 345 88 04
f:  +31 (0)20 - 345 88 06
e:  marc@roosit.eu


