From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-floppy: rename end_request handler properly
Date: Tue, 12 Feb 2008 21:10:45 +0100
Message-ID: <200802122110.45593.bzolnier@gmail.com>
References: <20080212143635.GA4530@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753246AbYBLV0t@vger.kernel.org>
In-Reply-To: <20080212143635.GA4530@gollum.tnic>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 12 February 2008, Borislav Petkov wrote:
> commit 48f9b88d491aa478ffcf21e2f523e3665db0770b
> Author: Borislav Petkov <petkovbb@gmail.com>
> Date:   Tue Feb 12 09:42:19 2008 +0100
> 
>     ide-floppy: rename end_request handler properly
>     
>     mv idefloppy_do_end_request -> idefloppy_end_request as is the case with ide-cd
>     
>     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
