From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Remove endianness attribute in ata_tf_to_fis
Date: Sun, 1 Sep 2013 09:21:47 -0400
Message-ID: <20130901132147.GB11520@htj.dyndns.org>
References: <1377966033-12256-1-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:36669 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab3IANVy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Sep 2013 09:21:54 -0400
Received: by mail-qe0-f45.google.com with SMTP id 6so345742qea.18
        for <linux-ide@vger.kernel.org>; Sun, 01 Sep 2013 06:21:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377966033-12256-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, Aug 31, 2013 at 09:20:32AM -0700, Marc C wrote:
> From: Marc Carino <marc.ceeeee@gmail.com>
> 
> This patch cleans up the following build warning:

Please roll these two changes into a single patch and state clearly
that it is a bug fix.

Thanks!

-- 
tejun
