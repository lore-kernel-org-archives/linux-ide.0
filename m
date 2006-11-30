From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] winbond IDE depends on IDEDMA
Date: Thu, 30 Nov 2006 20:27:23 +0100
Message-ID: <58cb370e0611301127i3ba278dbx49013204567882d6@mail.gmail.com>
References: <20061130143803.GA22451@aepfle.de>
	 <20061130185209.GB24071@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:47323 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S967907AbWK3T1Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 14:27:24 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3328189nfa
        for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 11:27:23 -0800 (PST)
In-Reply-To: <20061130185209.GB24071@aepfle.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On 11/30/06, Olaf Hering <olaf@aepfle.de> wrote:
>
> winbond ide depends on idedma.
> Move the option into the IDEDMA section.

Yep, this is better solution.

Andrew, please push upstream.

Bart
