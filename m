From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: reference to unknown "CONFIG_MPC8315_DS" variable
Date: Mon, 8 Mar 2010 05:42:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1003080540470.14702@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:51260 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab0CHLHy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 06:07:54 -0500
Received: from cpe00142a336e11-cm001ac318e826.cpe.net.cable.rogers.com ([174.113.191.234] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1NoaR5-00015O-Oz
	for linux-ide@vger.kernel.org; Mon, 08 Mar 2010 05:43:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


  from drivers/ata/sata_fsl.c:

  #ifdef CONFIG_MPC8315_DS

there appears to be no such CONFIG variable.

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
