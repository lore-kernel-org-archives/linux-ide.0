From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] ide: rename IDE_TFLAG_IN_[HOB_]FEATURE
Date: Wed, 18 Mar 2009 21:24:24 +0100
Message-ID: <200903182124.24796.bzolnier@gmail.com>
References: <200903182040.22335.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:35760 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbZCRU7V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2009 16:59:21 -0400
Received: by fk-out-0910.google.com with SMTP id 18so105765fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 18 Mar 2009 13:59:19 -0700 (PDT)
In-Reply-To: <200903182040.22335.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 18 March 2009, Sergei Shtylyov wrote:
> The feature register has never been readable -- when its location is read, one
> gets the error register value; hence rename IDE_TFLAG_IN_[HOB_]FEATURE into
> IDE_TFLAG_IN_[HOB_]ERROR and introduce the 'hob_error' field into the 'struct
> ide_taskfile' (despite the error register not really depending on the HOB bit).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied 1-2 and 3-4 (take 2)

Thanks!
