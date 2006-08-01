From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: skip protocol test altogether in spurious interrupt
 code
Date: Tue, 01 Aug 2006 19:12:25 +0900
Message-ID: <44CF2909.9040204@gmail.com>
References: <44CED5FF.6090701@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:3007 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932108AbWHAKMQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 06:12:16 -0400
Received: by nf-out-0910.google.com with SMTP id o25so221173nfa
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 03:12:15 -0700 (PDT)
In-Reply-To: <44CED5FF.6090701@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Unicorn Chang <uchang@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Unicorn Chang wrote:
> Skip protocol test altogether in spurious interrupt code. If PIOS is received
> when it shouldn't, ahci will raise protocol violation.
> 
> Signed-off-by: Unicorn Chang <uchang@tw.ibm.com>
Acked-by: Tejun Heo <htejun@gmai.com>

-- 
tejun
