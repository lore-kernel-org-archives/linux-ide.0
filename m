From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: implement ata_exec_internal_sg()
Date: Tue, 28 Nov 2006 04:02:36 -0500
Message-ID: <456BFB2C.9070901@pobox.com>
References: <11635120293623-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64642 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935688AbWK1JCi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:02:38 -0500
In-Reply-To: <11635120293623-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Sg'ify ata_exec_internal() and call it ata_exec_internal_sg().
> Wrapper function around ata_exec_internal_sg() is implemented to
> provide ata_exec_internal() interface.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


