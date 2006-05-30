From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/12] libata-hp-prep: make probing related functions
 global
Date: Tue, 30 May 2006 00:06:21 -0400
Message-ID: <447BC4BD.4050206@pobox.com>
References: <1148883958195-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:24547 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751462AbWE3EGg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:06:36 -0400
In-Reply-To: <1148883958195-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hotplug will be implemented in libata-eh.c.  Make ata_dev_read_id()
> and ata_dev_configure() global.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 8-9


