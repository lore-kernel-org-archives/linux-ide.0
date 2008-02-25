From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH 3/3] IDE: Coding Style fixes to drivers/ide/pci/cy82c693.c
Date: Mon, 25 Feb 2008 09:40:59 +0100
Message-ID: <4d8e3fd30802250040ie77dbecw6cc396a0f2a9285e@mail.gmail.com>
References: <20080224221144.1e9e7449@paolo-desktop>
	 <20080225073122.GE11327@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:65002 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbYBYIlA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 03:41:00 -0500
Received: by wf-out-1314.google.com with SMTP id 28so804934wff.4
        for <linux-ide@vger.kernel.org>; Mon, 25 Feb 2008 00:41:00 -0800 (PST)
In-Reply-To: <20080225073122.GE11327@elte.hu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Mon, Feb 25, 2008 at 8:31 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
>  * Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>
>  > Before:
>  > total: 34 errors, 14 warnings, 456 lines checked
>  >
>  > After:
>  > total: 0 errors, 8 warnings, 456 lines checked
>
>  sidenote: please also indicate to maintainers that the cleanup causes no
>  change in generated code. Find below of how one of your cleanup patches
>  looks like in its final form in x86.git. (i auto-generated all of the
>  commit log)
>
>  info like that makes it easier for maintainers to see the intended zero
>  impact of your changes.

Sure, I'll script that.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
