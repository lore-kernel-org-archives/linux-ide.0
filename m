From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: buffer size in the elevator
Date: Sun, 26 Mar 2006 23:41:42 +0200
Message-ID: <5d96567b0603261341g35192532r165ca38ddb8c3a3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:27336 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932139AbWCZVln convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Mar 2006 16:41:43 -0500
Received: by pproxy.gmail.com with SMTP id f25so1495927pyf
        for <linux-ide@vger.kernel.org>; Sun, 26 Mar 2006 13:41:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello guys.
first, since there is no mailing lists for the linux elevators i posting
this mailing lists.

I am testing the deadline elevator ( 2.6.15 ). i am sending
buffer sizes of 1M to the target but it seems that buffer no bigger than
1/2 MB are reaching the elevator and sometimes page sized buffers.

Why is that ? Does the bio vector size caueses it?

thank you.
--
Raz


PS.
I have written an asynchronous IO tester , if any of you wishes to get
it just say .
