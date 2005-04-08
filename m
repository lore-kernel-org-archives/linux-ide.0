From: Manu <nobody@guzu.net>
Subject: Oops when using HDIO_DRIVE_TASKFILE
Date: Fri, 08 Apr 2005 02:43:49 +0200
Message-ID: <4255D3C5.6000609@guzu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 26.mail-out.ovh.net ([213.186.42.179]:61347 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP id S262613AbVDGVoP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Apr 2005 17:44:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


As I'm playing a bit with HDIO_DRIVE_TASKFILE, the kernel always crashes
when I try to send data (TASKFILE_OUT).
Is this a known behaviour or did I misuse the ioctl ?

I'm using the last Gentoo kernel 2.6.11.6 (with Gentoo patches).

Thanks.

