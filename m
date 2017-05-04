From: Tycho Andersen <tycho@docker.com>
Subject: Re: [PATCH] ata-sff: always map page before data transfer
Date: Thu, 4 May 2017 16:18:15 -0600
Message-ID: <20170504221815.ldehw4ta5gfqfmpa@smitten>
References: <20170502162932.12578-1-tycho@docker.com>
 <20170504095134.GA14372@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:34231 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdEDWSQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 May 2017 18:18:16 -0400
Received: by mail-io0-f173.google.com with SMTP id k91so40282454ioi.1
        for <linux-ide@vger.kernel.org>; Thu, 04 May 2017 15:18:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170504095134.GA14372@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Juerg Haefliger <juerg.haefliger@hpe.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com

On Thu, May 04, 2017 at 02:51:34AM -0700, Christoph Hellwig wrote:
> And we should be fine.

Great, I just sent a v2. Thanks!

Tycho
