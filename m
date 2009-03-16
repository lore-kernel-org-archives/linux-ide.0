From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide-disk: use ATA_ERR
Date: Mon, 16 Mar 2009 18:59:33 +0100
Message-ID: <200903161859.33704.bzolnier@gmail.com>
References: <200903161833.08744.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:10291 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094AbZCPSIF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2009 14:08:05 -0400
Received: by fk-out-0910.google.com with SMTP id f33so1484927fkf.5
        for <linux-ide@vger.kernel.org>; Mon, 16 Mar 2009 11:08:00 -0700 (PDT)
In-Reply-To: <200903161833.08744.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 16 March 2009, Sergei Shtylyov wrote:
> Make use of ATA_ERR instead of hard-coded value in idedisk_set_max_address()
> and idedisk_read_native_max_address().
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
