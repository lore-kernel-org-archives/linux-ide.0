From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] ata: New PATA driver for Altera CompactFlash.
Date: Thu, 8 Oct 2009 10:55:03 +0100
Message-ID: <20091008105503.6ce414f5@lxorguk.ukuu.org.uk>
References: <1254967110-3495-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757331AbZJHJye@vger.kernel.org>
In-Reply-To: <1254967110-3495-1-git-send-email-thomas@wytron.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Nios2 development list <nios2-dev@sopc.et.ntust.edu.tw>, linux-kernel@vger.kernel.org, Thomas Chou <thomas@wytron.com.tw>, Ian Abbott <abbotti@mev.co.uk>
List-Id: linux-ide@vger.kernel.org

On Thu,  8 Oct 2009 09:58:30 +0800
Thomas Chou <thomas@wytron.com.tw> wrote:

> This patch adds a new PATA driver to support the Altera SOPC Builder
> CompactFlash component as a PATA device with support for insertion
> and removal of CF cards.  It uses the platform driver model.

Can you explain why you remove the interface rather than the device on
the interface when you detect a card removal ?
