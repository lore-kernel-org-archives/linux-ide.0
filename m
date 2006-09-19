From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 15/20] libata: move ->irq_handler from port_ops to port_info
Date: Tue, 19 Sep 2006 01:43:51 -0400
Message-ID: <450F8397.70700@pobox.com>
References: <1155977973478-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45471 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751027AbWISFoD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:44:03 -0400
In-Reply-To: <1155977973478-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

ideally we don't ever want to store info on the irq handler at all...

