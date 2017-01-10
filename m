From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: remove the global response buffer
Date: Tue, 10 Jan 2017 10:56:57 -0500
Message-ID: <20170110155657.GA6666@htj.duckdns.org>
References: <1484037708-654-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32850 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbdAJP5B (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 10:57:01 -0500
Received: by mail-pf0-f196.google.com with SMTP id 127so29553981pfg.0
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2017 07:57:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1484037708-654-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

On Tue, Jan 10, 2017 at 09:41:42AM +0100, Christoph Hellwig wrote:
> Avoid the need for a global 4k buffer by allocating no response buffer
> for commands that don't return data, a small on-stack one for the ATAPI
> fixup, or a kmalloced one for all other emulated commands.

Applied 1-5 to libata/for-4.11.  Will wait for the updated version of
the last patch.

Thanks.

-- 
tejun
