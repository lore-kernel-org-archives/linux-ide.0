From: Andrei Martynov <andrei.martynov@web.de>
Subject: libata: waiting for the drives to settle
Date: Thu, 20 Aug 2009 11:40:51 +0200
Message-ID: <54773205.20090820114051@web.de>
Reply-To: Andrei Martynov <andrei.martynov@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:49388 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZHTJk4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Aug 2009 05:40:56 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2B8E610E727F6
	for <linux-ide@vger.kernel.org>; Thu, 20 Aug 2009 11:40:57 +0200 (CEST)
Received: from [80.66.20.180] (helo=[10.149.109.31])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Me48f-0000hj-00
	for linux-ide@vger.kernel.org; Thu, 20 Aug 2009 11:40:57 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

what would be the right place in modern pata driver to implement the
following old code from function do_probe() in ide-probe.c ?

/*
 *  ColdFire platforms boot up so quick that most hard drives
 *  have not completed there own self tests. Pause here for
 *  a couple of seconds if it looks like there is a drive
 *  present...
 */
if (IN_BYTE(IDE_SELECT_REG) != drive->select.all) {
  printk("IDE: waiting for drives to settle...\n");
  for (rc = 0; (rc < 400); rc++) {
    SELECT_DRIVE(hwif,drive);
    ide_delay_50ms();
    if (IN_BYTE(IDE_SELECT_REG) == drive->select.all)
     break;
 }
}

It has to be executed once, so placing it into command handler is
probably not the right solution.
  

-- 
Best regards,
 Andrei                          mailto:andrei.martynov@web.de

