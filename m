From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide: use ATA_HOB
Date: Mon, 16 Mar 2009 19:00:06 +0100
Message-ID: <200903161900.06407.bzolnier@gmail.com>
References: <200903161834.31142.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:33397 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174AbZCPSIF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2009 14:08:05 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1203847fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 16 Mar 2009 11:08:02 -0700 (PDT)
In-Reply-To: <200903161834.31142.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 16 March 2009, Sergei Shtylyov wrote:
> Make use of ATA_HOB instead of hard-coded value in the tf_read() method.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
