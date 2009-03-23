From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: turn selectproc() method into dev_select() method (take 2)
Date: Mon, 23 Mar 2009 21:09:15 +0100
Message-ID: <200903232109.15688.bzolnier@gmail.com>
References: <200903231518.07703.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:53631 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbZCWUJn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2009 16:09:43 -0400
Received: by bwz17 with SMTP id 17so1928605bwz.37
        for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2009 13:09:40 -0700 (PDT)
In-Reply-To: <200903231518.07703.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, petkovbb@gmail.com

On Monday 23 March 2009, Sergei Shtylyov wrote:
> Turn selectproc() method into dev_select() method by teaching it to write to the
> device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied in place of old patch
