From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 14:44:32 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085172272.3083.98.camel@patibmrh9>
References: <200405211845.i4LIjbto024376@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:24274 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265977AbUEUUok
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 16:44:40 -0400
In-Reply-To: <200405211845.i4LIjbto024376@falcon10.austin.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: dwm@austin.ibm.com
Cc: linux-ide@vger.kernel.org

> I keep seeing you refer to 'plscsi'.

A plscsi command line is nothing but a more concise syntax for saying:

... open(...); ... ioctl(... ); ... close(... ); ... exit(...);

> Where would one find this tool?

Answered more fully now at:

Subject: [announce] plscsi in Linux
http://marc.theaimsgroup.com/?t=108517123300005

Pat LaVarre


