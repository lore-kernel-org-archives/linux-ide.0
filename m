From: "Christian Pernegger" <pernegger@gmail.com>
Subject: Re: Maxtor 7V300F0 on sil3114 VS Maxtor Atlas 15K2 on adaptec29160 strangeness
Date: Wed, 20 Feb 2008 00:13:25 +0100
Message-ID: <bb145bd20802191513v5e671ee3l34264fac0a677e6a@mail.gmail.com>
References: <bb145bd20802190437g5da22abcyb72ad63b5a939b1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:36488 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445AbYBSXN0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 18:13:26 -0500
Received: by py-out-1112.google.com with SMTP id u52so2856238pyb.10
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 15:13:25 -0800 (PST)
In-Reply-To: <bb145bd20802190437g5da22abcyb72ad63b5a939b1b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> can you post a dmesg?

These are all the logs / info I could get my hands on remotely.

The 'ubuntu' ones are from a boot with the Ubuntu 7.10 live-CD.
The 'native' ones are from the Debian lenny test install on the Atlas
The above have dmesg, lspci -vvnnxb and hdparm -I

The xml is from the dban-beta.
Rest is from various tries with dban-1.0.7
These last two might have more disks connected.

> what firmware is on the 7V300F0?

VA111630, according to hdparm -I

Thanks for helping,

C.
