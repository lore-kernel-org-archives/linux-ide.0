From: Jeff Garzik <jeff@garzik.org>
Subject: Module warning in drivers/ide
Date: Wed, 04 Oct 2006 05:07:36 -0400
Message-ID: <452379D8.2040704@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33696 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030547AbWJDJHn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Oct 2006 05:07:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

'make allmodconfig' spits this out at the end of the build:

WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05

