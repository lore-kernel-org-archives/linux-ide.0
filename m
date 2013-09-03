From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: bugfix: Remove __le32 in ata_tf_to_fis
Date: Tue, 3 Sep 2013 10:39:53 -0400
Message-ID: <20130903143953.GH10522@htj.dyndns.org>
References: <1378051141-2652-1-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:38884 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab3ICOj5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Sep 2013 10:39:57 -0400
Received: by mail-ve0-f175.google.com with SMTP id oy10so3984129veb.20
        for <linux-ide@vger.kernel.org>; Tue, 03 Sep 2013 07:39:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1378051141-2652-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Sep 01, 2013 at 08:59:01AM -0700, Marc C wrote:
> From: Marc Carino <marc.ceeeee@gmail.com>
> 
> The endianness attribute on the 'aux' local variable is a wrong, and
> can lead to issues on big-endian machines,
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>

Applied to libata/for-3.12.

Thanks.

-- 
tejun
