From: "Grant Grundler" <grundler@google.com>
Subject: Re: weird throughput on write to SATA disk
Date: Mon, 13 Oct 2008 14:35:11 -0700
Message-ID: <da824cf30810131435v6756ed7cg264bbb0d09c0ac08@mail.gmail.com>
References: <1223925629.3947.7.camel@duo>
	 <da824cf30810131407m1a73bd11xa30fd118ee5a4c8f@mail.gmail.com>
	 <1223932956.3947.22.camel@duo>
	 <da824cf30810131434r34179666kc8d075c7eecdbbae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:59824 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYJMVfU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 17:35:20 -0400
In-Reply-To: <da824cf30810131434r34179666kc8d075c7eecdbbae@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 13, 2008 at 2:34 PM, Grant Grundler <grundler@google.com> wrote:
...
> Can you try "dd oflag=direct if=/dev/null of=/dev/sdb bs=64k"?

sorry...meant to type "if=/dev/zero"...I don't recall if /dev/null
will work the same.

grant
