From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Sun, 02 Aug 2009 02:05:53 +0400
Message-ID: <4A74BC41.4000203@ru.mvista.com>
References: <bug-13882-11633@http.bugzilla.kernel.org/> <200908012130.n71LURC3026649@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32574 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752479AbZHAWF7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Aug 2009 18:05:59 -0400
In-Reply-To: <200908012130.n71LURC3026649@demeter.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

--- Comment #15 from Alan <alan@lxorguk.ukuu.org.uk> 2009-08-01 21:30:26 ---
> I have complete documentation for them. They are set by the BIOS to indicate
> whether the cable is 40 or 80 wire. We cannot do drive side detect as there is
> no guarantee the boards support it.
>   

I wonder how boards can support (or not) *drive side* cable detection...


