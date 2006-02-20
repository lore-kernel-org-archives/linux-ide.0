From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: rename ata_dev_id_[c_]string()
Date: Mon, 20 Feb 2006 04:54:50 -0500
Message-ID: <43F991EA.8040205@pobox.com>
References: <11397520242535-git-send-email-htejun@gmail.com> <43EF8BB8.2020609@pobox.com> <20060213010246.GA9621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:13264 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932435AbWBTJy5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 04:54:57 -0500
In-Reply-To: <20060213010246.GA9621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch renames ata_dev_id_[c_]string() to ata_id_[c_]string().
> All other functions which read data from ATA ID data start with ata_id
> and those two function names were getting too long.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


