From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] drivers/ide-cd: Handle missing driver data during
 status check gracefully
Date: Wed, 08 Nov 2017 09:08:17 +0900 (KST)
Message-ID: <20171108.090817.1057428368415111720.davem@davemloft.net>
References: <CA+55aFxBEMsrqTPOST18iQ_VwNkFxqWq744W74M+8VVT2eL-3w@mail.gmail.com>
        <20171107163723.7u5iyvewrrjglqif@pd.tnic>
        <CA+55aFy+peFp-u753gu43L5eisPE8g-P_eCyx-amoBADm-k0NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:58874 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdKHAIX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2017 19:08:23 -0500
In-Reply-To: <CA+55aFy+peFp-u753gu43L5eisPE8g-P_eCyx-amoBADm-k0NA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: bp@alien8.de, fengguang.wu@intel.com, linux-ide@vger.kernel.org, axboe@kernel.dk, bart.vanassche@sandisk.com, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Nov 2017 09:13:04 -0800

> On Tue, Nov 7, 2017 at 8:37 AM, Borislav Petkov <bp@alien8.de> wrote:
>>
>> Here it is:
> 
> Thanks, applied directly.

Thanks for taking care of this.
