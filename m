From: dwm@austin.ibm.com
Subject: Re: [PATCH] atapi request sense work
Date: Fri, 21 May 2004 13:45:37 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405211845.i4LIjbto024376@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pixpat.austin.ibm.com ([192.35.232.241]:23111 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S265953AbUEUSpk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 14:45:40 -0400
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat,

  I keep seeing you refer to 'plscsi'.  Where would one find this tool?

++doug

On 21 May 2004 11:59:08 MDT, Pat LaVarre wrote:
...
>
>$ plscsi /dev/sg0 -X time 5 0 -i 8 -x "25 00 00:00:00:00 00 00:00 00" -v
>x 00000000 25 00 00:00:00:00 00 00:00 00 .. .. .. .. .. .. "%@@@@@@@@@"
>x 00000000 00:00:00:00 00:00:00:00 .. .. .. .. .. .. .. .. "@@@@@@@@"
>// 0 = plscsi.main exit int


