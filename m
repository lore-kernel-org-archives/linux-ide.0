From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] disable debug in IDE ppc/pmac driver
Date: Fri, 7 Jan 2005 03:21:28 +0100
Message-ID: <58cb370e05010618213416c19@mail.gmail.com>
References: <20050105080740.GA19267@suse.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:26386 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261195AbVAGCV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2005 21:21:28 -0500
Received: by wproxy.gmail.com with SMTP id 37so116051wra
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2005 18:21:28 -0800 (PST)
In-Reply-To: <20050105080740.GA19267@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Wed, 5 Jan 2005 09:07:40 +0100, Olaf Hering <olh@suse.de> wrote:
> 
> Ben did not disagree to hide the 3 additional lines printed when booting
> my ibook with the 'quiet' cmdline option.
> I think these debug printk have no real value for normal operation.

applied
