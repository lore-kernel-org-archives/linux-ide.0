From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Status of the sata_sil driver for the VT8237
Date: Sun, 28 Mar 2004 14:40:31 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4067383F.1030805@clanhk.org>
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com> <40664AE4.8010003@clanhk.org> <406680AB.8090204@stesmi.com> <4066833B.4080004@clanhk.org> <4067340A.5080709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.clanhk.org ([69.93.101.154]:50352 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262176AbUC1UkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2004 15:40:18 -0500
In-Reply-To: <4067340A.5080709@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> Do you really plan to get 300MB/sec from two disks?  :)


Yes, for about 50-100ms at a time, and -to- the disks, not from them; 
well, the caches anyway.  On 133MB/s PCI, more like 150-300ms of 
saturation on bursts, and shared with the NICs.  I have very short and 
bursty I/O patterns as is typical in real-time applications.  It's 
easier to guarantee latency when your pipes are always at a small 
fraction of their potential.  100ms higher latency, even for part of a 
second, is quite noticeable in what I serve.

-ryan

PS 2.6 dropped my latencies under load by about 90% over 2.4!  We're 
talking 40-80ms application response time under high load to 8-10ms 
under high load.  <3
