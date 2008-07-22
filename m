From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11148] New: AHCI driver work incorrectly, HDD
 hand when havy load.
Date: Tue, 22 Jul 2008 15:26:28 -0700
Message-ID: <20080722152628.e36e4da0.akpm@linux-foundation.org>
References: <bug-11148-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39462 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752182AbYGVW06 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 18:26:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6MMQS1R010777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 15:26:29 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m6MMQS6F021232
	for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 15:26:28 -0700
In-Reply-To: <bug-11148-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, 22 Jul 2008 15:07:52 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11148
> 
>            Summary: AHCI driver work incorrectly, HDD hand when havy load.

A regression in 2.6.26.
