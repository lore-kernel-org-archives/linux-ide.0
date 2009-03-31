From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide: call {in|out}put_data() methods from tf_{read|load}() methods (take 3)
Date: Tue, 31 Mar 2009 20:32:21 +0200
Message-ID: <200903312032.21513.bzolnier@gmail.com>
References: <200903312224.15089.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:24427 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbZCaS3L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2009 14:29:11 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1137761fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2009 11:29:08 -0700 (PDT)
In-Reply-To: <200903312224.15089.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 31 March 2009, Sergei Shtylyov wrote:
> Handle IDE_FTFLAG_{IN|OUT}_DATA flags in tf_{read|load}() methods by calling
> {in|out}put_data() methods to transfer 2 bytes -- this will allow us to move
> that handling out of those methods altogether...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Changes since take 2:
> - removed no longer used mm_{inw|outw}() from ide-h8300.c...

No... please... just make it an incremental change.

"take 2" was already applied and I'm pushing it to Linus RIGHT NOW
