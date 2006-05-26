From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/2] libata: legacy mode fixes
Date: Fri, 26 May 2006 13:58:54 +0800
Message-ID: <4476991E.5060506@tw.ibm.com>
References: <20060524165006.GC12022@harddisk-recovery.com> <4476947A.3020003@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:49127 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030484AbWEZF6y
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 May 2006 01:58:54 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4Q5wrHf013807
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 01:58:53 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4Q5wrCM184396
	for <linux-ide@vger.kernel.org>; Thu, 25 May 2006 23:58:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4Q5wqA3014496
	for <linux-ide@vger.kernel.org>; Thu, 25 May 2006 23:58:53 -0600
In-Reply-To: <4476947A.3020003@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, rene.herman@keyaccess.nl, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Dear all,

Description:
This is the revised patch by Unicorn and I for legacy mode fix.

patch 1/2: make both legacy ports share one host_set.
patch 2/2: remove the unused ap->hard_port_no.

Patch against the upstream branch of libata-dev tree 
(957d2df1801865eb1e63864bc63b970aa9c460ba).

For your review, thanks.

Unicorn Chang
Albert Lee

