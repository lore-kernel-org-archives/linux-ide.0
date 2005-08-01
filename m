From: Lukasz Kosewski <lkosewsk@gmail.com>
Subject: Re: [info] Silicon Image device hotplug debounce
Date: Sun, 31 Jul 2005 23:12:37 -0700
Message-ID: <355e5e5e05073123121fd7e13f@mail.gmail.com>
References: <42E672C1.4000502@pobox.com>
	 <loom.20050801T061802-766@post.gmane.org>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:21770 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262334AbVHAGMh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Aug 2005 02:12:37 -0400
Received: by zproxy.gmail.com with SMTP id r28so728926nza
        for <linux-ide@vger.kernel.org>; Sun, 31 Jul 2005 23:12:37 -0700 (PDT)
In-Reply-To: <loom.20050801T061802-766@post.gmane.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ricky Cheng <rickycheng@qnap.com.tw>
Cc: linux-ide@vger.kernel.org

On 7/31/05, Ricky Cheng <rickycheng@qnap.com.tw> wrote:
> Hi, This is Ricky. I am finding solution of sil 3512 chip hotswap problem.
> I think this doc can help some. But I don't really understand libata very much.
> Can someone help some ideas?..Thanks
> I know I should do something in interrupt handler in libata.c like check
> status of plug/unplug. Is is right?

Yo.

I'm working on a hotswap infrastructure patch right now that would
give you the API necessary to perform a hotswap.  There are
essentially two parts:

1)  The driver has to recognize that a plug/unplug event occurred
2)  libata has to take the appropriate action to plug/unplug a device.

Currently, I have only done step 1) for the sata_promise driver.  Step
2) is being... well, written.  Since you're doing hotswap stuff,
great, you can test it for me (I am in China until September with no
goddamn hardware to test with)!

Look (tonight, over the next few hours in fact) for messages of the
type "Add disk hotswap support to libata." I should have some patches
sent in by then.

Luke Kosewski
