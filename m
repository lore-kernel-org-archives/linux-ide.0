From: Albert Lee <albertcc@tw.ibm.com>
Subject: About the naming of ata_drive_probe_reset()
Date: Thu, 18 May 2006 11:00:32 +0800
Message-ID: <446BE350.5000504@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:61133 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750718AbWERDAe
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 23:00:34 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4I30TX5003350
	for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 23:00:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4I30TBl192384
	for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 21:00:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4I30TeP024627
	for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 21:00:29 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Hi Tejun,

The ata_drive_probe_reset() is not drive-specific. 
Actually what got reset is the port. (I guess the "drive" doesn't mean device here.)
Maybe something like ata_port_probe_reset() or ata_do_probe_reset() is less ambiguous?

-- albert

