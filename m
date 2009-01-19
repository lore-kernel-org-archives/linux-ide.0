From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 0/6] ide: more core code housekeeping
Date: Mon, 19 Jan 2009 17:19:16 +0300
Message-ID: <49748BE4.4000505@ru.mvista.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53003 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758825AbZASOSq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:18:46 -0500
In-Reply-To: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> SFF I/O code goes to ide-io-sff.c and error handling to ide-eh.c...

    There's no such thing as SFF I/O code I'm afraid -- whatever libata 
authors might think...

MBR, Sergei
