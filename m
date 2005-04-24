From: Kallol Biswas <kallol@nucleodyne.com>
Subject: 2.6 SATA driver for Silicon Image 3124 controller
Date: 23 Apr 2005 23:58:17 -0700
Message-ID: <1114325896.2882.6.camel@localhost.localdomain>
Reply-To: kallol@nucleodyne.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.202.56]:12164 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262273AbVDXHHt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Apr 2005 03:07:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,
      We need to develop/port the 2.4 linux driver for SATA 3124 Silicon
Image controller  to 2.6 kernel. 

We have a limitation that the device registers can not be accessed in
memory space.

Do we have any driver available for the above controller for 2.6 linux
kernel?

It seems the controller has a IO BAR register. 

How difficult is it to get the technical documentation on the adapter?

Kallol

NucleoDyne Systems Inc.
kallol@nucleodyne.com
408-718-8164

